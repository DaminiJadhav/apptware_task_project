import org.junit.runner.RunWith;
import org.junit.Rule;
import com.example.error_reporting_features_in_a_flutter_app.MainActivity;
import com.example.error_reporting_features_in_a_flutter_app;
import dev.flutter.plugins.integration_test.FlutterTestRunner;
import androidx.test.rule.AndroidTestRule;

@RunWith(FlutterTestRunner.classs)
public class MainActivityTest{
    @Rule
    public ActivityTestRule<MainActivity> rule=new ActivityTestRule<>(MainActivity.class,true,false);
}