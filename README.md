# unhBlock

Block ads, malware, tracking + more on systems running Unbound as a resolver.

![unhBlock][unhblock-gif]

This project is based on [UnboundBL][unboundbl-link] and like it depends on
Unbound DNS to blackhole undesired content. unhBlock has been written with
maintainability in mind.

## Current Features

* Add, download and parse [blocklist URLs][blacklist-sample]
* Add, download and parse [whitelist URLs][whitelist-sample]
* Redirect to user defined IP address (i.e. pixelserv)
* Redirect to user defined CNAME record (i.e. pixelserv)
* Confirm valid Unbound configuration
* Optionally reload Unbound configuration

## Installation

### OPNsense

Use OPNsense branch.

1. Drop unhBlock in `/usr/home`
2. Drop [sample action][opnsense-action] file in `/usr/local/opnsense/service/conf/actions`
3. Edit action definition as needed
4. Drop [blacklist][blacklist-sample] sources file in `var/unhBlock/`
5. Drop [whiltelist][whitelist-sample] sources file in `/var/unhBlock`
6. Reload configd `service configd restart`
7. Test action `configctl unhBlock start`

## Recommended configuration

For best results redirect all domains found in blocklists to a host on your
network using a [PixelServ][pixelserv-link] via the `-b/--blackhole` flag.
Optionally redirect unwanted traffic employing a `CNAME` record via `--type
CNAME` option and parameter.

For my own personal configuration, I redirect all traffic to a PixelServ that is
reachable only via a [`Traefik`][traefik-link] router to support SSL.
Feel free to inspect the [sample service file][pixel-service] and [Traefik
config][traefik-config].

## Sample Lists

The sample lists in this repository were created based user recommendations.

## License

[BSD-3-Clause][license]

## Author Information

Carlos Hernandez | [e-mail](mailto:hurricanehrndz@techbyte.ca)

[whitelist-sample]: samples/whitelist
[blacklist-sample]: samples/blacklist
[unboundbl-link]: 'https://github.com/alectrocute/UnboundBL'
[license]: 'https://raw.githubusercontent.com/hurricanehrndz/unhBlock/master/LICENSE'
[opnsense-action]: samples/OPNsense/actions_unhBlock.conf
[pixelserv-link]: 'https://hub.docker.com/r/imthai/pixelserv-tls'
[traefik-link]: 'https://containo.us/traefik/'
[recommend-lists]: 'https://discourse.pi-hole.net/t/update-the-best-blocking-lists-for-the-pi-hole-alternative-dns-servers-2019/13620'
[pixelserv-service]: samples/pixelserv/pixelserv.service
[traefik-config]: samples/traefik/traefik.yml
[unhblock-gif]: /samples/unhBlock.gif
