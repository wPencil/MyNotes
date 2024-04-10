import matplotlib.pyplot as plt

# test data
x = [1, 2, 3, 4, 5]
y = [10, 15, 7, 10, 5]

# 1. Default plot--------------------------------------------------
plt.plot(x, y)  # Creating Line Charts
plt.title("折线图示例")
plt.xlabel("X 轴标签")
plt.ylabel("Y 轴标签")
plt.legend()  # Show legend

plt.savefig("default_plot.png")

# 2. Set font to SongTi--------------------------------------------
plt.rcParams["font.sans-serif"] = ["SimSun"] # Display Chinese correctly
plt.rcParams["axes.unicode_minus"] = False   # Solve the problem of negative sign display


plt.plot(x, y)  # Creating Line Charts
plt.title("折线图示例")
plt.xlabel("X 轴标签")
plt.ylabel("Y 轴标签")
plt.legend()  # Show legend

plt.savefig("SongTi_plot.png")

# 3. Set specified font-------------------------------------------
plt.rcParams["font.sans-serif"] = [""] # Display Chinese correctly
plt.rcParams["axes.unicode_minus"] = True   # Solve the problem of negative sign display

plt.rcParams["font.family"] = "Times New Roman" # Set the font to "Times New Roman"

plt.plot(x, y)  # Creating Line Charts
plt.title("line chart example")
plt.xlabel("I am x axis")
plt.ylabel("I am y axis")
plt.legend()  # Show legend

plt.savefig("specified_font_plot.png")