from parser.aggregation import normalize_prefix

def test_normalize_prefix():

    result = normalize_prefix(
        "2001:db8::1/64"
    )

    assert result == "2001:db8::/64"