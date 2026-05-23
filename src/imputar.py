import polars as pl  # type: ignore[import-untyped]
import os

os.makedirs("data/interim", exist_ok=True)
df = pl.read_csv("data/interim/validado.csv")

dfI = df.with_columns(
    pl.col("nota1").fill_null(pl.col("nota1").median()),
    pl.col("nota2").fill_null(pl.col("nota2").median()),
    pl.col("nota3").fill_null(pl.col("nota3").median()),
    pl.col("asistencia").fill_null(pl.col("asistencia")).mean().round(),
)

os.makedirs("data/interim", exist_ok=True)
dfI.write_csv("data/interim/imputado.csv")

# TODO se puede cambiar la forma de imputar revisando la columna de tiene_faltantes
