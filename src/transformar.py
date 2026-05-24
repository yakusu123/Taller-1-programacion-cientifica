import polars as pl  # type: ignore[import-untyped]
import os

os.makedirs("data/interim", exist_ok=True)
df = pl.read_csv("data/interim/imputado.csv")
#revision de los datos de notas para clasificarlos y definir si estan aprobados
notasF = df.with_columns(
    promedio=pl.mean_horizontal("nota1", "nota2", "nota3").round(2),
    aprobado=pl.when(pl.mean_horizontal("nota1", "nota2", "nota3") > 4)
    .then(True)
    .otherwise(False)
    .alias("Aprobado"),
    categoria=pl.when(pl.mean_horizontal("nota1", "nota2", "nota3") > 6)
    .then(pl.lit("Destacado"))
    .otherwise(
        pl.when(pl.mean_horizontal("nota1", "nota2", "nota3") > 4)
        .then(pl.lit("Aprobado"))
        .otherwise(pl.lit("Reprobado"))
    )
    .alias("categoria"),
)

os.makedirs("data/processed", exist_ok=True)
notasF.write_csv("data/processed/transformado.csv")
