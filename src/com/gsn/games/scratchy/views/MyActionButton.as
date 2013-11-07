package com.gsn.games.scratchy.views {

    import com.gsn.games.shared.components.mcbutton.MCButton;

    import flash.display.MovieClip;
    import flash.text.TextField;

    /**
     * Extension of the MCButton to add control of the label text field.
     *
     * */
    public class MyActionButton extends MCButton {

        private var _textField:TextField;

        public function MyActionButton(targetMc:MovieClip, buttonText:String = null) {
            super(targetMc);

            if (buttonText) {
                this.label = buttonText;
            }
        }

        public function set label(buttonText:String):void {
            if (!_textField) {
                _textField = this.controlledMc.getChildByName("PROP_Label") as TextField;
            }
            if (_textField) {
                _textField.text = buttonText;
            }
        }
    }
}
