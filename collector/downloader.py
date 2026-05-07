import requests
from pathlib import Path

def download_file(url: str, output_path: str):
    response = requests.get(url, stream=True, timeout=60)

    if response.status_code != 200:
        raise Exception(f"Failed to download {url}")

    Path(output_path).parent.mkdir(
        parents=True,
        exist_ok=True
    )

    with open(output_path, "wb") as f:
        for chunk in response.iter_content(8192):
            f.write(chunk)

    return output_path