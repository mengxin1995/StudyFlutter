package top.kikit.androidhost;

import android.content.Intent;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

import io.flutter.facade.Flutter;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Flutter.startInitialization(this.getApplicationContext());
        Intent intent = new Intent(this, MyFlutterActivity.class);
        startActivity(intent);
    }
}
