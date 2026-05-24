import polars as pl  # type: ignore[import-untyped]
import os

os.makedirs("data/processed", exist_ok=True)
df = pl.read_csv("data/processed/transformado.csv")

# variables para almacenar la informacion a utilizar en metricas futuras
promedio = df["promedio"].mean()
alumnos = df["nombre"].count()
aprobados = df["aprobado"]
contAprobados = 0
for aprobado in aprobados:
    if aprobado == "aprobado":
        contAprobados += 1
categorias = df["categoria"]
contDestacados = 0
contReprobados = 0
contCategorias = 0
# revisa cada categoria y cuanta en general a cual corresponde
for categoria in categorias:
    if categoria == "Destacado":
        contDestacados += 1
    elif categoria == "reprobado":
        contReprobados += 1
    elif categoria == "aprobado":
        contCategorias += 1
asistencia = df["asistencia"].mean()

# escritura de un archivo desde 0
os.makedirs("data/processed", exist_ok=True)
with open("data/processed/resumen.txt", mode="w", encoding="utf-8") as f:
    f.write("cantidad de alumnos" + str(alumnos) + "\n")
    f.write("promedio del curso" + str(promedio) + "\n")
    for i in range(alumnos):
        f.write(
            "la mejor nota de "
            + df["nombre"][i]
            + "es un "
            + str(max(df["nota1"][i], df["nota2"][i], df["nota3"][i]))
            + "y la nota mas baja es "
            + str(min(df["nota1"][i], df["nota2"][i], df["nota3"][i]))
            + "\n"
        )
    f.write("cantidad de alumnos aprobados es " + str(contAprobados) + "\n")
    f.write("cantidad de alumnos destacados es " + str(contDestacados) + "\n")
    f.write("cantidad de alumnos solo aprobados es " + str(contCategorias) + "\n")
    f.write("cantidad de alumnos reprobados es " + str(contReprobados) + "\n")
    f.write("el promedio de asistencia es " + str(asistencia) + "\n")
