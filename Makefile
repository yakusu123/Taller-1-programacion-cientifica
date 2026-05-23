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
DATA_DIR = data
RAW_DIR = $(DATA_DIR)/raw
INTERIM_DIR = $(DATA_DIR)/interim
PROCESSED_DIR = $(DATA_DIR)/processed

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
DATA_RESUM = $(PROCESSED_DIR)/reporte_validacion.txt

# "make" o "make all" corre todo el pipeline
# TODO: agrega las reglas para cada paso del pipeline
all: $(DATA_TRASNFORM)
	@echo.
	@echo Pipeline completado exitosamente!
	@echo todo funciona/
# ============================================================
# PASOS DEL PIPELINE
# ============================================================
# TODO: escribe una regla por cada paso
# Recuerda: cada target debe tener sus dependencias y su comando
$(DATA_VALIDATE) $(DATA_REPORT): $(DATA_RAW) src/validar.py
	$(PYTHON) src/validar.py

$(DATA_IMPUTAR): $(DATA_VALIDATE) src/imputar.py
	$(PYTHON) src/imputar.py

$(DATA_TRASNFORM): $(DATA_IMPUTAR) src/transformar.py
	$(PYTHON) src/transformar.py

$(DATA_RESUM)): $(DATA_TRASNFORM) src/resumir.py
	$(PYTHON) src/resumir.pý



