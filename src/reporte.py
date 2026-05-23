import polars as pl  # type: ignore[import-untyped]
import os
import datetime

os.makedirs("data/processed", exist_ok=True)
df = pl.read_csv("data/processed/transformado.csv")
with open("data/processed/resumen.txt", mode="r", encoding="utf-8") as r:
    txt = r.read()

alumnos = df["nombre"].count()

with open("data/processed/reporte_final.md", mode="w", encoding="utf-8") as f:
    f.write("#REPORTE FINAL" + str(datetime.today()) + "\n")
    f.write("| nombre | nota 1 | nota 2 | nota 3 | promedio |" + "\n")
    f.write("|________|________|________|________|__________|" + "\n")
    for i in range(alumnos):
        f.write(
            "| "
            + str(df["nombre"][i])
            + " |"
            + str(df["nota1"][i])
            + " |"
            + str(df["nota2"][i])
            + " |"
            + str(df["nota3"][i])
            + " |"
            + str(df["promedio"][i])
            + " |"
            + "\n"
        )
    f.write("|______________________________________________|" + "\n")
    f.write(txt)
    f.write("#Observaciones \n")
    f.write(
        "los datos nullos iniciales fueron una nota1, una nota2, una nota3 y 2 asistencias"
    )
