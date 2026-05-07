import ipaddress

def normalize_prefix(prefix: str):
    network = ipaddress.IPv6Network(
        prefix,
        strict=False
    )

    return str(network)