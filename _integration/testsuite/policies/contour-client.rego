# Copyright 2020 VMware, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License.  You may obtain
# a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations
# under the License.

package contour.http.client

# target_addr returns the IP address for the proxy that tests should
# send requests through.
target_addr = "0.0.0.0" {
  not data.test.params.proxy.address
}

# target_addr returns the IP address for the proxy that tests should
# send requests through.
target_addr = ip {
  ip := data.test.params.proxy.address
}

# target_http_port returns the non-TLS port for the proxy that tests should
# send requests through.
target_http_port = "9100" {
  not data.test.params.proxy.http_port
}

# target_http_port returns the non-TLS port for the proxy that tests should
# send requests through.
target_http_port = port {
  port := data.test.params.proxy.http_port
}

# target_https_port returns the TLS port for the proxy that tests should
# send requests through.
target_https_port = "9143" {
  not data.test.params.proxy.https_port
}

# target_https_port returns the TLS port for the proxy that tests should
# send requests through.
target_https_port = port {
  port := data.test.params.proxy.https_port
}

# ua returns a user agent string specific to this test run.
ua(prefix) = useragent {
  useragent := sprintf("%s/%s", [prefix, data.test.params["run-id"]])
}

# Get take a http.send argument and sends a GET request.
Get(params) = response {
  to_send := {
    "method": "GET",
  }

  response := http.send(object.union(to_send, params))
} else = response {
  # If the Get wasn't evaluated for any reason, return a dummy object to ensure
  # subsequent field references are valid.
  response := {
    "status_code": 0,
    "body": {},
    "headers": {},
  }
}
