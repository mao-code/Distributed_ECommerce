import http from 'k6/http';
import { sleep } from 'k6';

export let options = {
  stages: [
    { duration: '30s', target: 50 },   // ramp-up
    { duration: '1m',  target: 100 },  // steady high load
    { duration: '20s', target: 0 },    // ramp-down
  ],
};

export default function () {
  http.post('http://127.0.0.1:30081/order',
            JSON.stringify({ productId: 'p1' }),
            { headers: { 'Content-Type': 'application/json' } });
  sleep(0.2);
}