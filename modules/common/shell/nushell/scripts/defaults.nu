const domains_cache_path = $"($nu.temp-path)/macos-defaults-domains.msgpack";

export def domains [] {
  try {
    open $domains_cache_path | from msgpackz
  } catch {
    let domains = (^defaults domains | split row ", ");
    $domains | to msgpackz | save $domains_cache_path;
    $domains
  }
}

export def read [domain: string@domains, key?: string] {
  let path = $"($env.HOME)/Library/Preferences/($domain).plist";
  let contents = open $path;

  if ($key == null) {
    $contents
  } else {
    $contents | get $key
  }
}
