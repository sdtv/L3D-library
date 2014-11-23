package L3D;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;

import org.json.JSONObject;
import org.json.JSONArray;
import java.util.*;

public class Spark {

	// public static List<String> availableCores;
	public static JSONObject availableCores;
	public static JSONArray allCores;
	private static String accessToken;
	public static String name;

	public static String readAll(Reader rd) {
		StringBuilder sb = new StringBuilder();
		try {
			int cp;
			while ((cp = rd.read()) != -1) {
				sb.append((char) cp);
			}
		} catch (Exception e) {
			System.out.println("ran into an error while reading data");
			System.out.println(e);
		}
		return sb.toString();
	}

	public static JSONObject readJsonFromUrl(String url) {
		try {
			InputStream is = new URL(url).openStream();
			try {
				BufferedReader rd = new BufferedReader(new InputStreamReader(
						is, Charset.forName("UTF-8")));
				String jsonText = readAll(rd);
				JSONObject json = new JSONObject(jsonText);
				return json;
			} catch (Exception e) {
				System.out.println("trouble parsing JSON");
				System.out.println(e);
				return new JSONObject();
			} finally {

				is.close();
			}
		} catch (Exception e) {
			System.out.println("trouble opening the URL: " + url);
			System.out.println(e);
			return new JSONObject();
		}
	}

	public static JSONArray readJsonArrayFromUrl(String url) {
		try {
			InputStream is = new URL(url).openStream();
			try {
				BufferedReader rd = new BufferedReader(new InputStreamReader(
						is, Charset.forName("UTF-8")));
				String jsonText = readAll(rd);
				JSONArray json = new JSONArray(jsonText);
				return json;
			} catch (Exception e) {
				System.out.println("trouble parsing JSON");
				System.out.println(e);
				return new JSONArray();
			} finally {

				is.close();
			}
		} catch (Exception e) {
			System.out.println("trouble opening the URL: " + url);
			System.out.println(e);
			return new JSONArray();
		}
	}

	public Spark(String token) {
		accessToken = token;
		try {
			loadCores();
		} catch (Exception e) {
			System.out.println("cannot load the cores");
		}
	}

	void loadCores() {
		String url;
		try {
			url = "https://api.spark.io/v1/devices/?access_token="
					+ accessToken;
			allCores = readJsonArrayFromUrl(url);
			System.out.println("Finding available cubes");
			System.out.println("checking URL: " + url);
			// availableCores = new ArrayList<String>();
			availableCores = new JSONObject();
			for (int i = 0; i < allCores.length(); i++) {
				JSONObject core = allCores.getJSONObject(i);
				if (core.getBoolean("connected")) {
					String deviceID = core.getString("id");
					String coreName = core.getString("name");
					JSONObject currentCore = new JSONObject();
					currentCore.put("name", coreName);
					currentCore.put("deviceID", deviceID);
					String deviceURL = "https://api.spark.io/v1/devices/"
							+ deviceID + "/?access_token=" + accessToken;
					System.out.println("getting variables for core");
					System.out.println("checking URL: " + deviceURL);
					JSONObject thisCore = readJsonFromUrl(deviceURL);
					JSONObject activeVariables = thisCore
							.getJSONObject("variables");
					System.out.println(thisCore.toString());

					Iterator<?> keys = activeVariables.keys();

					while (keys.hasNext()) {
						String variableName = keys.next().toString();
						String variableURL = "https://api.spark.io/v1/devices/"
								+ deviceID + "/" + variableName
								+ "/?access_token=" + accessToken;
						System.out.println("getting value of variable "+variableName);
						System.out.println(variableURL);
						JSONObject variable = readJsonFromUrl(variableURL);
						if (activeVariables.getString(variableName).equals(
								"string")) {
							String value = variable.getString("result");
							currentCore.put(variableName, value);
						} else if (activeVariables.getString(variableName)
								.equals("int32")) {
							int value = variable.getInt("result");
							currentCore.put(variableName, value);
						} else if (activeVariables.getString(variableName)
								.equals("float")) {
							float value = (float) variable.getDouble("result");
							currentCore.put(variableName, value);
						}
					}

					// add the current core to the list of available cores
					// TODO -- check to make sure the variables aren't all null
					// before putting it in the list
					availableCores.put(coreName, currentCore);

					System.out.println(core.getString("name"));
				}
			}
		} catch (Exception e) {
			System.out.println("error loading core info from the spark cloud");
			System.out.println(e);
		}

		System.out.println("available cores:");
		Iterator<?> keys = availableCores.keys();
		while (keys.hasNext()) {
			String key = keys.next().toString();
			System.out.println(key);
		}
	}

	private static String getVar(String coreName, String varName) {
		try {
			JSONObject core = availableCores.getJSONObject(coreName);
			return core.getString(varName);
		} catch (Exception e) {
			System.out.println("that wasn't a JSON object");
			return null;
		}
	}

	public static String getAddress(String _name) {
		return getVar(_name, "IPAddress");
	}

}
