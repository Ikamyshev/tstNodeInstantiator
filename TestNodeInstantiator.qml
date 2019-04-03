//Test3d
import QtQuick 2.0 as QQ2
import QtQml 2.11
import QtQml.Models 2.11

import QtQuick.Scene3D 2.0
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0

QQ2.Item {
    Scene3D {
        id: scene
        anchors.fill: parent
        cameraAspectRatioMode: Scene3D.AutomaticAspectRatio
        multisample: true
        Entity {
            Camera {
                id: camera
                projectionType: CameraLens.PerspectiveProjection
                fieldOfView: 45
                aspectRatio: 1820 / 1080
                nearPlane: 0.1
                farPlane: 1000.0
                position: Qt.vector3d( 0.0, 0.0, 100.0 )
                upVector: Qt.vector3d( 0.0, 1.0, 0.0 )
                viewCenter: Qt.vector3d( 0.0, 0.0, 0.0 )
            }
            FirstPersonCameraController { camera: camera }
            components: [
                RenderSettings {
                    activeFrameGraph: ForwardRenderer {
                        camera: camera
                        clearColor: "transparent"
                    }
                }
            ]
            property var circlesPositions: [
                Qt.vector3d( 0.0,  0.0,  0.0),
                Qt.vector3d( 2.0,  5.0, -15.0),
                Qt.vector3d(-1.5, -2.2, -2.5),
                Qt.vector3d(-3.8, -2.0, -12.3),
                Qt.vector3d( 2.4, -0.4, -3.5),
                Qt.vector3d(-1.7,  3.0, -7.5),
                Qt.vector3d( 1.3, -2.0, -2.5),
                Qt.vector3d( 1.5,  2.0, -2.5),
                Qt.vector3d( 1.5,  0.2, -1.5),
                Qt.vector3d(-1.3,  1.0, -1.5),
            ]
            Timer {
                interval: 500; running: true; repeat: true
                onTriggered: {
                    entityModel.append({ y: Math.random()*10 })
                    console.log("timer", Math.random()*10)
                }
            }

            QQ2.ListModel {
                id: entityModel
                QQ2.ListElement { y: 0 }
                QQ2.ListElement { y: 3 }
            }

            NodeInstantiator {
                id: collection
                model: entityModel
                delegate:
                    Entity {
                        components: [
                            Transform {
                                id: objTransform
                                property real userTranslation: 90.0
                                translation: Qt.vector3d(-6.0, y, userTranslation)
                            },
                            SphereMesh { radius: 3 },
                            PhongMaterial { }
                        ]
                        QQ2.NumberAnimation {
                            target: objTransform
                            property: "userTranslation"
                            duration: 10000
                            from: 97
                            to: 0

                            loops: QQ2.Animation.Infinite
                            running: true
                        }
                    }
            }
        }
    }
}
