import gleam/list
import lustre/attribute
import lustre/effect
import lustre/element/html.{button, div, input, text}
import plinth/browser/document
import plinth/browser/element
import plinth/browser/window
import sketch/styles/components/command_dialog/command_dialog_styles as styles

pub opaque type CommandDialogProps(msg) {
  CommandDialogProps(
    msg,
    visible: Bool,
    placeholder: String,
    input_value: String,
    is_valid: Bool,
    submit_attributes: List(attribute.Attribute(msg)),
    cancel_attributes: List(attribute.Attribute(msg)),
    input_attributes: List(attribute.Attribute(msg)),
  )
}

pub fn new(
  msg msg,
  visible visible: Bool,
  placeholder placeholder: String,
  input_value input_value,
  is_valid is_valid: Bool,
  submit_attributes submit_attributes: List(attribute.Attribute(msg)),
  cancel_attributes cancel_attributes: List(attribute.Attribute(msg)),
  input_attributes input_attributes: List(attribute.Attribute(msg)),
) -> CommandDialogProps(msg) {
  CommandDialogProps(
    msg,
    visible,
    placeholder,
    input_value,
    is_valid,
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
        command_input_view(
          placeholder: props.placeholder,
          input_value: props.input_value,
          is_valid: props.is_valid,
          input_attributes: props.input_attributes,
        ),
        command_dialog_button_view(
          props.submit_attributes,
          props.cancel_attributes,
          props.is_valid,
        ),
      ]),
    ],
  )
}

fn command_input_view(
  placeholder placeholder: String,
  input_value input_value: String,
  is_valid is_valid: Bool,
  input_attributes input_attributes,
) {
  let invalid_attributes = case is_valid {
    True -> []
    False -> [attribute.class(styles.command_input_invalid)]
  }
  div([attribute.style([#("display", "flex")]), ..input_attributes], [
    input([
      attribute.type_("text"),
      attribute.autofocus(True),
      attribute.value(input_value),
      attribute.class(styles.command_input),
      attribute.id(styles.command_input),
      attribute.autocomplete("off"),
      attribute.attribute("autocorrect", "off"),
      attribute.attribute("spellcheck", "false"),
      attribute.attribute("inputmode", "text"),
      attribute.placeholder(placeholder),
      ..invalid_attributes
    ]),
  ])
}

fn command_dialog_button_view(
  submit_attributes submit_attributes,
  cancel_attributes cancel_attributes,
  is_valid is_valid: Bool,
) {
  let invalid_attributes = case is_valid {
    True -> []
    False -> [
      attribute.class(styles.submit_button_disabled),
      attribute.disabled(True),
    ]
  }
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
      list.append(
        [
          attribute.class(styles.command_dialog_button),
          attribute.class(styles.submit_button),
          ..submit_attributes
        ],
        invalid_attributes,
      ),
      [text("Submit")],
    ),
  ])
}

pub fn focus_command_dialog_input_effect() {
  effect.from(fn(_) {
    window.request_animation_frame(fn(_) {
      let assert Ok(el) = document.get_element_by_id(styles.command_input)
      element.focus(el)
    })
    Nil
  })
}
