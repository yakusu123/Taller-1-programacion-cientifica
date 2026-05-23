#################################################################################
# GLOBALS                                                                       #
#################################################################################

PROJECT_NAME = taller 1 programacion cientifica
PYTHON_VERSION = 3.12
PYTHON_INTERPRETER = python


# ============================================================
# VARIABLES - Completa las rutas que faltan
# ============================================================
PYTHON = python
LINTER = ruff
DATA_DIR = data
RAW_DIR = $(DATA_DIR)/raw
INTERIM_DIR = $(DATA_DIR)/interim
PROCESSED_DIR = $(DATA_DIR)/processed
REPORT = reports

# TODO: define el archivo de datos crudos
DATA_RAW = $(RAW_DIR)/estudiantes.csv

# TODO: define el archivo de datos validados
DATA_VALIDATE = $(INTERIM_DIR)/validado.csv

# TODO: define el archivo de reporte
DATA_REPORT = $(PROCESSED_DIR)/reporte_validacion.txt

#archivo con datos imputados
DATA_IMPUTAR = $(INTERIM_DIR)/imputado.csv

#archivo con transformacion de datos y promedios de notas
DATA_TRANSFORM = $(PROCESSED_DIR)/transformado.csv

#archivo con las metricas obtenidas
DATA_RESUM = $(PROCESSED_DIR)/resumen.txt

DATA_REPORTE = $(REPORT)/reporte_final.md

# "make" o "make all" corre todo el pipeline
# TODO: agrega las reglas para cada paso del pipeline
all: lint $(DATA_REPORTE)
	@echo.
	@echo Pipeline completado exitosamente!

lint:
	$(LINTER) check src/*.py
	$(LINTER) format --check src/*.py
# ============================================================
# PASOS DEL PIPELINE
# ============================================================
# TODO: escribe una regla por cada paso
# Recuerda: cada target debe tener sus dependencias y su comando
$(DATA_VALIDATE) $(DATA_REPORT): $(DATA_RAW) src/validar.py
	$(PYTHON) src/validar.py

$(DATA_IMPUTAR): $(DATA_VALIDATE) src/imputar.py
	$(PYTHON) src/imputar.py

$(DATA_TRANSFORM): $(DATA_IMPUTAR) src/transformar.py
	$(PYTHON) src/transformar.py

$(DATA_RESUM): $(DATA_TRANSFORM) src/resumir.py
	$(PYTHON) src/resumir.py

$(DATA_REPORTE): $(DATA_RESUM) $(DATA_TRANSFORM) src/reporte.py
	$(PYTHON) src/reporte.py
.PHONY: limpiar
limpiar:
	@echo Eliminando archivos generados...
	del /f /q $(subst /,\,$(DATA_VALIDATE) $(DATA_REPORT) $(DATA_IMPUTAR) $(DATA_TRANSFORM) $(DATA_RESUM) $(DATA_REPORTE))
	@echo Listo! Puedes correr make de nuevo.

.PHONY: estado
estado:
	@echo ============================================
	@echo  Estado del Pipeline
	@echo ============================================
	@echo.
	@echo [ DATOS CRUDOS ]
	@if exist $(DATA_RAW)       (echo   OK $(DATA_RAW))       else (echo   -- $(DATA_RAW)   no existe)
	@echo.
	@echo [ PROCESADOS ]
	@if exist $(DATA_VALIDATE)  (echo   OK $(DATA_VALIDATE))  else (echo   -- $(DATA_VALIDATE) no existe)
	@if exist $(DATA_REPORT)    (echo   OK $(DATA_REPORT))    else (echo   -- $(DATA_REPORT)   no existe)
	@if exist $(DATA_IMPUTAR)   (echo   OK $(DATA_IMPUTAR))   else (echo   -- $(DATA_IMPUTAR)  no existe)
	@if exist $(DATA_TRANSFORM) (echo   OK $(DATA_TRANSFORM)) else (echo   -- $(DATA_TRANSFORM) no existe)
	@if exist $(DATA_RESUM)     (echo   OK $(DATA_RESUM))     else (echo   -- $(DATA_RESUM)     no existe)
	@echo.
	@echo [ REPORTES ]
	@if exist $(DATA_REPORTE)   (echo   OK $(DATA_REPORTE))   else (echo   -- $(DATA_REPORTE)   no existe)
	@echo.
	@echo ============================================
