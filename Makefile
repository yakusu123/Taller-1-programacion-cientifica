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

# TODO: define el archivo de datos crudos
DATA_RAW = $(RAW_DIR)/estudiantes.csv

# TODO: define el archivo de datos validados
DATA_VALIDATE = $(INTERIM_DIR)/validado.csv

# TODO: define el archivo de reporte
DATA_REPORT = $(PROCESSED_DIR)/reporte_validacion.txt

# "make" o "make all" corre todo el pipeline
# TODO: agrega las reglas para cada paso del pipeline
all: $(DATA_VALIDATE) $(DATA_REPORT)
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



