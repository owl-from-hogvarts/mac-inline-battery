import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Alternative to GroupBox for when we want the title to always be left aligned.
Rectangle {
	id: control
	Layout.fillWidth: true
	default property alias _contentChildren: content.data
	property string label: ""
	color: "#00000000"
	border.width: 2
	border.color: "#00000000"
	// radius: 5
	property int padding: 8
	implicitHeight: childrenRect.height + padding + padding
	property alias spacing: content.spacing

	Label {
		id: title
		visible: control.label
		text: control.label
		font.bold: true
		font.pointSize: 13
		anchors.leftMargin: padding
		// anchors.topMargin: padding
		anchors.left: parent.left
		anchors.top: parent.top
		anchors.right: parent.right
		height: visible ? implicitHeight : padding
	}

	ColumnLayout {
		id: content
		anchors.top: title.bottom
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.margins: padding
		// spacing: 0
		// height: childrenRect.height

		// Workaround for crash when using default on a Layout.
		// https://bugreports.qt.io/browse/QTBUG-52490
		// Still affecting Qt 5.7.0
		Component.onDestruction: {
			while (data.length > 0) {
				data[data.length - 1].parent = control;
			}
		}
	}
}
