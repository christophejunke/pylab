import cProfile


def run():
    p = cProfile.Profile()
    counter = 0
    p.enable()
    for i in range(1, 3000):
        for i in range(1, 75):
            with open("Makefile") as file:
                for line in file:
                    counter += 1
    p.disable()
    p.print_stats(sort='cumulative')
    return counter
