import re

IPV6_PATTERN = re.compile(
    r'([0-9a-fA-F]{0,4}:){2,7}[0-9a-fA-F]{0,4}/[0-9]+'
)

def extract_ipv6_prefixes(text: str):
    matches = IPV6_PATTERN.finditer(text)

    prefixes = set()

    for match in matches:
        prefixes.add(match.group())

    return sorted(prefixes)