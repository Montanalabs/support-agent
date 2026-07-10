#! VULNERABLE support agent — resolves the ticket using the untrusted text directly.
#! `check` -> UNSAFE: tainted ticket text reaches an (irreversible) resolution tool.
grant resolve cost 20 irreversible
budget 100

let ticket = fetch<web>
commit { resolve(ticket) }  # tainted -> tool: REJECTED
