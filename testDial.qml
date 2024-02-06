import QtQuick 6.5

Item {
    id: root
    visible: true
    width: 800
    height: 600

    Rectangle {
        width: 800
        height: 600
        color: "lightblue"

        // Цикл для створення 24 прямокутників
        Repeater {
            model: 24

            Rectangle {
                width: 50
                height: 20
                color: "red"

                // Використовуйте координати та кут для позиціонування прямокутників
                x: 400 + 150 * Math.cos((360 / 24) * index * (Math.PI / 180))
                y: 300 + 150 * Math.sin((360 / 24) * index * (Math.PI / 180))
                rotation: 15 * index // Кут повороту
            }
        }
    }
}
