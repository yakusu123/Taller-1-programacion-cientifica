import polars as pl  # type: ignore[import-untyped]
import os

df = pl.read_csv("data/raw/estudiantes.csv")

df = df.with_columns(tiene_faltantes=pl.any_horizontal(pl.all().is_null()))
os.makedirs("data/interim", exist_ok=True)
df.write_csv("data/interim/validado.csv")

nulo = df.null_count()
rango = df.filter(
    (pl.col("nota1") < 1)
    | (pl.col("nota1") > 7)
    | (pl.col("nota2") < 1)
    | (pl.col("nota2") > 7)
    | (pl.col("nota3") < 1)
    | (pl.col("nota3") > 7)
    | (pl.col("asistencia") > 100)
    | (pl.col("asistencia") < 0)
)

print(nulo)
print(df.filter(pl.col("tiene_faltantes")))
print(rango)

os.makedirs("data/interim", exist_ok=True)
dftxt = df
dftxt.write_csv("data/interim/reporte_validacion.txt")

with open("data/interim/reporte_validacion.txt", mode="a", encoding="utf-8") as f:
    f.write("nulos por columnas\n")
    f.write(str(nulo) + "\n")
    f.write(str(df.filter(pl.col("tiene_faltantes"))) + "\n")
    f.write(str(rango) + "\n")
