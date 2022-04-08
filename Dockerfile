FROM continuumio/miniconda
WORKDIR /app

COPY requirements.txt requirements.txt

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]

# Create the environment:
COPY environment.yml .
# Create the conda environment
RUN conda env create -n faml -f environment.yml

# Make RUN commands use `bash --login`:
SHELL ["/bin/bash", "--login", "-c"]

# Initialize conda in bash config fiiles:
RUN conda init bash

# Make RUN commands use the new environment:
SHELL ["conda", "run", "-n", "faml", "/bin/bash", "-c"]

# RUN conda activate faml

EXPOSE 8000

COPY . .

CMD ["conda", "run", "-n", "faml", "uvicorn", "fastapi_skeleton.main:app", "--host", "0.0.0.0", "--port", "8000"]
# CMD ["uvicorn", "fastapi_skeleton.main:app", "--host", "0.0.0.0", "--port", "8000"]

