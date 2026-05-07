import ipaddress

def validate_prefix(prefix: str):
    try:
        ipaddress.IPv6Network(prefix)
        return True
    except Exception:
        return False