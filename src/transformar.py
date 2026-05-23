import polars as pl  # type: ignore[import-untyped]
import os

os.makedirs("data/interim", exist_ok=True)
df = pl.read_csv("data/interim/imputado.csv")

notasF = df.with_columns(
    promedio = pl.mean("nota1","nota2","nota3"),
    aprobado = pl.when(pl.mean("nota1","nota2","nota3") > 4).then(True).otherwise(False).alias("aprobado"),
    categoria = pl.when(pl.mean("nota1","nota2","nota3") > 6).then("Destacado").otherwise(pl.when(pl.mean("nota1","nota2","nota3") > 4).then(True).otherwise(False).alias("aprobado")).alias("categoria")
)

os.makedirs("data/processed", exist_ok=True)
notasF.write_csv("data/processed/transformado.csv")