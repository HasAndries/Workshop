import http from 'k6/http';
import { check, group, sleep } from "k6";
import { Rate } from "k6/metrics";

export let options = {
	// max_vus: 100,
	// vus: 100,
	stages: [
		{ duration: "30s", target: 50 },
        { duration: "30s", target: 100  },
		{ duration: "1m", target: 100  },
		{ duration: "30s", target: 50 }
    ],
	thresholds: {
		transaction_time: ["avg<1000"],
		http_req_duration: ["avg<2000"],
	}
};
export let FailureRate = new Rate("global_failure_rate");

let text = "testing"
let url = 'https://app-echo-api-dev.azurewebsites.net/?text=' + text;

export default function() {
    var params =  { 
        headers: { 
            "accept": "text/plain",
        } 
    };
    var res = http.get(url, params);
    check(res, {
        "status is 200 (OK)": (r) => r.status == 200,
        "content-type is text/plain": (r) => r.headers['Content-Type'] == "text/plain; charset=utf-8",
        "content correct": (r) => r.body == text,
        "request duration <200ms": (r) => r.timings.duration < 200
    }) || FailureRate.add(1);

  http.get(url);
  sleep(0.1);
}

