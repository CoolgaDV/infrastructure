package cdv.infrastructure;

import java.io.IOException;
import java.nio.file.Paths;

/**
 * @author Dmitry Kulga
 *         04.11.2017 12:15
 */
public class DeployManager {

    private final String workingDirectory;
    private final String startScript;
    private final String stopScript;

    public DeployManager(String workingDirectory, String startScript, String stopScript) {
        this.workingDirectory = workingDirectory;
        this.startScript = startScript;
        this.stopScript = stopScript;
    }

    public void start() throws IOException, InterruptedException {
        new ProcessBuilder()
                .command("sh", startScript)
                .directory(Paths.get(workingDirectory).toFile())
                .inheritIO()
                .start()
                .waitFor();
    }

    public void stop() throws IOException, InterruptedException {
        new ProcessBuilder()
                .command("sh", stopScript)
                .directory(Paths.get(workingDirectory).toFile())
                .inheritIO()
                .start()
                .waitFor();
    }

}
