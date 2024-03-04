import requests
import zipfile
import os
import argparse
import uuid

def do_request(input_file, lang):
    headers = {
        'accept': '*/*',
    }

    try:
        files = {
            'removeImagesAfter': (None, 'true'),
            'clean': (None, 'true'),
            'deskew': (None, 'true'),
            'cleanFinal': (None, 'true'),
            'ocrRenderType': (None, 'hocr'),
            'fileInput': ('Offre_de_stage.pdf', open(input_file, 'rb'), 'application/pdf'),
            'ocrType': (None, 'force-ocr'),
            'languages': (None, lang),
            'sidecar': (None, 'true'),
        }
    except FileNotFoundError:
        print('Error: File not found')
        exit(1)

    try:
        response = requests.post('http://localhost:8080/api/v1/misc/ocr-pdf', headers=headers, files=files)
    except requests.exceptions.RequestException as e:
        print('Error:', e)
        exit(1)
    if response.status_code != 200:
        print('Error:', response.status_code, response.text)
        exit(1)
    
    print('Success:', response.status_code)
    
    return response

def main(input_file, output_folder, lang):
    response = do_request(input_file, lang)

    tmp_file = str(uuid.uuid4()) + '.zip'

    # Save the response content to a file
    with open(tmp_file, 'wb') as f:
        f.write(response.content)

    # Extract the content of the zip file
    with zipfile.ZipFile(tmp_file, 'r') as zip_ref:
        zip_ref.extractall(output_folder)

    # Remove the zip file
    os.remove(tmp_file)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='')
    parser.add_argument('input', help='Input file')
    parser.add_argument('--output', help='Output folder', default='output', const='output', nargs='?')
    parser.add_argument('--lang', help='Language', default='eng', const='eng', nargs='?')
    args = parser.parse_args()

    main(args.input, args.output, args.lang)