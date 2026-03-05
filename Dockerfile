# Stirling PDF — API-only PDF processing for Deposium pipeline
#
# v1.6.0 pinned: v2.2.0+ had RAM explosion issues.
# Check for updates: https://github.com/Stirling-Tools/Stirling-PDF/releases
#
# Benchmark (2026-03-04, PDF 1.2MB scientific paper):
#   20x concurrent pdf-to-text: 2.3s wall, 30% RAM on 3GB/2CPU
#   0 errors, 0 OOM — scales linearly with CPU for pdf-to-text
FROM frooodle/s-pdf:1.6.0

COPY ./configs /configs
COPY ./trainingData /usr/share/tessdata

ENV DOCKER_ENABLE_SECURITY=true \
    SECURITY_ENABLE_LOGIN=true \
    SECURITY_INITIALLOGIN_USERNAME=admin \
    SECURITY_INITIALLOGIN_PASSWORD=stirling \
    #
    # ── JVM ──
    # MaxRAMPercentage=75% auto-adapts to Railway resources:
    #   Railway 12GB → ~9GB heap (was hardcoded Xmx6144m)
    JAVA_TOOL_OPTIONS="-Xms512m -XX:MaxRAMPercentage=75.0 -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+UseStringDeduplication -XX:+UseContainerSupport -XX:+ExitOnOutOfMemoryError" \
    #
    # ── Session limits for ~100 concurrent connections (12GB/16vCPU) ──
    # Stirling defaults: LibreOffice=1, Tesseract=1 (fully serialized!)
    PROCESSEXECUTOR_SESSIONLIMIT_LIBREOFFICESESSIONLIMIT=8 \
    PROCESSEXECUTOR_SESSIONLIMIT_TESSERACTSESSIONLIMIT=8 \
    PROCESSEXECUTOR_SESSIONLIMIT_OCRMYPDFSESSIONLIMIT=16 \
    PROCESSEXECUTOR_SESSIONLIMIT_GHOSTSCRIPTSESSIONLIMIT=16 \
    PROCESSEXECUTOR_SESSIONLIMIT_PYTHONOPENCVSESSIONLIMIT=16 \
    PROCESSEXECUTOR_SESSIONLIMIT_WEASYPRINTSESSIONLIMIT=16 \
    #
    # ── Disable telemetry & unnecessary features ──
    SYSTEM_ENABLEANALYTICS=false \
    SYSTEM_ENABLEPOSTHOG=false \
    SYSTEM_ENABLESCARF=false \
    SYSTEM_SHOWUPDATE=false \
    #
    # ── Disable CLI endpoints (API-only) ──
    ENDPOINTS_TOREMOVE=cli

EXPOSE 8080
