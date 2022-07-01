from cx_Freeze import Executable, setup

base = None

executables = [Executable("main.py", base=base)]

packages = [
            "redminelib",
            "json",
            ]

excludes = []

options = {"build_exe": {"packages": packages, "excludes": excludes}}

setup(
    name = "ExecutarTarefas",
    options = options,
    version = "1.0",
    description = "Usado para executar tarefas",
    executables = executables
)