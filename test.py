import cProfile


def run():
    p = cProfile.Profile()
    p.enable()
    for i in range(1, 3000):
        for i in range(1, 75):
            with open("Makefile") as file:
                for line in file:
                    pass
    p.disable()
    p.print_stats(sort='cumulative')
