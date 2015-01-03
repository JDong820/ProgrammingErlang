import matplotlib.pyplot as plt
from subprocess import check_output
from sys import stdout

TIM = "tim"
MAX_TRIAL = 240000
INTERVAL = 3297


def get_data(program, max_trial):
    data_x = []
    data_yRu = []
    data_yRe = []
    for trial in range(1, max_trial, INTERVAL):
        runtime, realtime = check_output(["escript",
                                          program,
                                          str(trial)]).decode().split(" ")
        data_x.append(trial)
        data_yRu.append(float(runtime))
        data_yRe.append(float(realtime))
        print("{}%\b\b\b\b".format(int(100*trial/MAX_TRIAL)), end='')
        stdout.flush()
    print("100%")
    return data_x, data_yRu, data_yRe

if __name__ == "__main__":
    X, Y1, Y2 = get_data(TIM, MAX_TRIAL)
    plt.plot(X, Y1, 'g^', X, Y2, 'rs')
    plt.xlabel("Total Erlang processes started")
    plt.ylabel("Startup time per Erlang process")
    plt.savefig("ErlangProcessesGraph.pdf")
