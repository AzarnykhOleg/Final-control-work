package core.model;

import java.util.Scanner;

public class Exit extends Mode {

    public Exit() {
        super("exit", "выход");
    }

    @Override
    public void execute(Scanner scanner) {
        System.out.println("-> выход...");
        System.exit(0);
    }
}
