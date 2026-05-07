from storage.models import IPv6Route

def save_route(db, prefix, collector):
    route = IPv6Route(
        prefix=prefix,
        collector=collector
    )

    db.add(route)
    db.commit()

    return route