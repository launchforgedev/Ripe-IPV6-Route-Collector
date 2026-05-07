from parser.bgp_parser import extract_ipv6_prefixes

def test_extract_ipv6_prefixes():

    text = "2001:db8::/64"

    result = extract_ipv6_prefixes(text)

    assert "2001:db8::/64" in result