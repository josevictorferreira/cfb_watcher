import lustre/attribute
import lustre/element/html.{button, div, input, text}
import sketch/styles/components/command_dialog/command_dialog_styles as styles

pub opaque type CommandDialogProps(msg) {
  CommandDialogProps(
    msg,
    visible: Bool,
    input_value: String,
    submit_attributes: List(attribute.Attribute(msg)),
    cancel_attributes: List(attribute.Attribute(msg)),
    input_attributes: List(attribute.Attribute(msg)),
  )
}

pub fn new(
  msg,
  visible: Bool,
  input_value,
  submit_attributes: List(attribute.Attribute(msg)),
  cancel_attributes: List(attribute.Attribute(msg)),
  input_attributes: List(attribute.Attribute(msg)),
) -> CommandDialogProps(msg) {
  CommandDialogProps(
    msg,
    visible,
    input_value,
    submit_attributes,
    cancel_attributes,
    input_attributes,
  )
}

pub fn view(props: CommandDialogProps(msg)) {
  let visibility_classes = case props.visible {
    True -> [attribute.class(styles.show)]
    False -> []
  }

  div(
    [
      attribute.class(styles.dialog_overlay),
      attribute.id(styles.dialog_overlay),
      ..visibility_classes
    ],
    [
      div([attribute.class(styles.command_dialog)], [
        command_input_view(props.input_value, props.input_attributes),
        command_dialog_button_view(
          props.submit_attributes,
          props.cancel_attributes,
        ),
      ]),
    ],
  )
}

fn command_input_view(input_value, input_attributes) {
  div([attribute.style([#("display", "flex")]), ..input_attributes], [
    input([
      attribute.autofocus(True),
      attribute.value(input_value),
      attribute.class(styles.command_input),
      attribute.id(styles.command_input),
      attribute.placeholder("Enter command..."),
    ]),
  ])
}

fn command_dialog_button_view(submit_attributes, cancel_attributes) {
  div([attribute.style([#("text-align", "right")])], [
    button(
      [
        attribute.class(styles.command_dialog_button),
        attribute.class(styles.cancel_button),
        ..cancel_attributes
      ],
      [text("Cancel")],
    ),
    button(
      [
        attribute.class(styles.command_dialog_button),
        attribute.class(styles.submit_button),
        ..submit_attributes
      ],
      [text("Submit")],
    ),
  ])
}
