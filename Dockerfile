FROM nikolaik/python-nodejs:python3.10-nodejs19

# avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# install system deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# set workdir first
WORKDIR /app

# copy only requirements first (cache optimization)
COPY requirements.txt .

# upgrade pip + install deps
RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir -r requirements.txt

# now copy rest of project
COPY . .

# run
CMD ["bash", "start"]
