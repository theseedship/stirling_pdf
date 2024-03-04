Pour rédiger un README spécifique à l'ajout d'une langue via Tesseract OCR en téléchargeant les fichiers de langue depuis GitHub et en les plaçant dans le dossier `tessdata`, voici une structure adaptée :

---

# Lancer stirling-pdf

```bash
$ docker-compose up
```

# Ajout d'une nouvelle langue à Tesseract OCR

Ce README vous guide à travers le processus d'ajout d'une nouvelle langue à StrirlingPDF pour améliorer la reconnaissance de texte dans vos documents PDF. Suivez les étapes ci-dessous pour intégrer une langue supplémentaire.

## Étape 1 : Téléchargement du fichier de langue

1. Rendez-vous sur le dépôt GitHub Tesseract-OCR tessdata à l'adresse suivante : [https://github.com/tesseract-ocr/tessdata](https://github.com/tesseract-ocr/tessdata).
2. Parcourez la liste pour trouver le fichier de langue souhaité. Les fichiers sont nommés selon le code ISO 639-2 de la langue (par exemple, `fra` pour le français).
3. Téléchargez le fichier `.traineddata` correspondant à la langue que vous souhaitez ajouter.

## Étape 2 : Ajout du fichier de langue à StrirlingPDF

1. Copiez le fichier `.traineddata` téléchargé dans le dossier `trainingData`.

## Étape 3 : Redémarrage de StrirlingPDF

1. Redémarrez StrirlingPDF pour que les modifications soient prises en compte.
```bash
$ docker-compose restart
```