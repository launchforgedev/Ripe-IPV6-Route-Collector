import asyncio

async def process_routes(routes, save_func):

    tasks = []

    for route in routes:
        tasks.append(
            save_func(route)
        )

    await asyncio.gather(*tasks)