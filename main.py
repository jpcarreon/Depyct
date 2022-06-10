import sys
import os

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

import reader

def run():
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    main = reader.MainWindow()
    engine.rootContext().setContextProperty("backend", main)
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())


if __name__ == "__main__":
    run()