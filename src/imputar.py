import polars as pl  # type: ignore[import-untyped]
import os

df = pl.read_csv("data/interim/validado.csv")

dfI = df.with_columns(
    pl.col("nota1").fill_null(pl.col("nota1").median()),
    pl.col("nota2").fill_null(pl.col("nota2").median()),
    pl.col("nota3").fill_null(pl.col("nota3").median()),
    df.with_columns(pl.col("asistencia").fill_null(pl.col("asistencia")).mean()))

dfI.write_csv("data/processed/imputado.csv")
