import matplotlib.pyplot as plt
import pandas as pd
import os

n = len(os.listdir("query_analyzer/performance"))
dataframes = []
for j in range(5):
    query_info = {}
    for i in range(1, n + 1):
        filename = f"query_analyzer/performance/query_performance_results_{i}.txt"
        with open(filename, 'r') as file:
            lines = file.readlines()
            pos = j * 6
            cost = float(lines[pos + 1].split(":")[1].strip())
            best_time = float(lines[pos + 2].split(":")[1].strip())
            avg_time = float(lines[pos + 3].split(":")[1].strip())
            worst_time = float(lines[pos + 4].split(":")[1].strip())
            query_info[i] = {'cost': cost, 'best_time': best_time, 'avg_time': avg_time, 'worst_time': worst_time}
    dataframes.append(pd.DataFrame(query_info).transpose())

for df in dataframes:
    fig, ax = plt.subplots(figsize=(6, 2))
    ax.axis('tight')
    ax.axis('off')
    table = ax.table(cellText=df.values, colLabels=df.columns, loc='center')
    fig.dpi = 300
    plt.show()

for df in dataframes:
    print(df.to_excel)

    fig, axes = plt.subplots(nrows=2, ncols=1, figsize=(10, 8))

    initial_best_time = df['best_time'].iloc[0]
    final_best_time = df['best_time'].iloc[-1]
    best_time_change = ((final_best_time - initial_best_time) / initial_best_time) * 100

    initial_avg_time = df['avg_time'].iloc[0]
    final_avg_time = df['avg_time'].iloc[-1]
    avg_time_change = ((final_avg_time - initial_avg_time) / initial_avg_time) * 100

    initial_worst_time = df['worst_time'].iloc[0]
    final_worst_time = df['worst_time'].iloc[-1]
    worst_time_change = ((final_worst_time - initial_worst_time) / initial_worst_time) * 100

    df.plot(ax=axes[0], y=['best_time', 'avg_time', 'worst_time'], marker='o')
    axes[0].set_ylabel('Time (s)')
    axes[0].set_title(f"Query Time ( Best : {best_time_change:.2f}%, Avg : {avg_time_change:.2f}%, Worst : {worst_time_change:.2f}% )")
    axes[0].legend()

    initial_cost = df['cost'].iloc[0]
    final_cost = df['cost'].iloc[-1]
    cost_change = ((final_cost - initial_cost) / initial_cost) * 100

    df.plot(ax=axes[1], y='cost', color='r', marker='o')
    axes[1].set_ylabel('Cost')
    axes[1].set_title(f"Query Cost {cost_change:.2f}%")
    axes[1].legend()

    plt.tight_layout()
    plt.show()
