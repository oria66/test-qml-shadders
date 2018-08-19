import QtQuick 2.11
import QtQuick.Window 2.11

Window {
    visible: true
    width: 1366
    height: 768
    title: qsTr("Hello World")

    Rectangle{
        anchors.fill: parent
        color: '#1e1e1e'

        Row{
            anchors.centerIn: parent
            spacing: 20

            Image {
                id: sourceImage
                source: "nube.PNG"
            }

            ShaderEffect{
                id: effect
                width: sourceImage.width
                height: sourceImage.height
                property real redChannel: 0.3
                property variant source: sourceImage
                NumberAnimation on redChannel {
                    from: 0.0
                    to: 1.0
                    duration: 1000
                    loops: Animation.Infinite
                }

                fragmentShader: "
                    varying highp vec2 qt_TexCoord0;
                    uniform sampler2D source;
                    uniform lowp float qt_Opacity;
                    uniform lowp float redChannel;
                    void main() {
                        gl_FragColor = texture2D(source, qt_TexCoord0) * vec4(redChannel, 1.0, 1.0, 1.0) * qt_Opacity;
                    }
                "
            }

            ShaderEffect{
                id: effect2
                width: sourceImage.width
                height: sourceImage.height
                property variant source: sourceImage

                vertexShader: "
                uniform highp mat4 qt_Matrix;
                attribute highp vec4 qt_Vertex;
                attribute highp vec2 qt_MultiTexCoord0;
                varying highp vec2 qt_TexCoord0;

                void main()
                {
                    qt_TexCoord0 = qt_MultiTexCoord0;
                    gl_Position = qt_Matrix * qt_Vertex;
                }"

                fragmentShader: "
                varying highp vec2 qt_TexCoord0;
                uniform sampler2D source;
                uniform lowp float qt_Opacity;

                void main() {
                    gl_FragColor = texture2D(source, qt_TexCoord0) * qt_Opacity;
                }"
            }

        }
    }


}
