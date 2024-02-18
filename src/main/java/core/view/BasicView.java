package core.view;

import core.control.BasicControl;
import core.control.Control;

public interface BasicView {
    public void start(BasicControl control, String text);

    public BasicControl getControl();
}
