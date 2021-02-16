import sys

from PySide2.QtWidgets import QApplication, QWidget, QVBoxLayout, QLabel, QPushButton


class Window(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Pyside Boilerplate")

        layout = QVBoxLayout(self)
        self.setLayout(layout)

        btn_1 = QPushButton("Button One")
        layout.addWidget(btn_1)

        btn_2 = QPushButton("Button Two")
        layout.addWidget(btn_2)

        label = QLabel("Hello World")
        layout.addWidget(label)


if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = Window()
    window.show()
    sys.exit(app.exec_())
