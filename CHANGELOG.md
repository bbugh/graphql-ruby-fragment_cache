# Change log

## master

## 1.6.0 (2021-03-13)

- [PR#54](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/54) Include arguments in selections_cache_key ([@bbugh][])

## 1.5.1 (2021-03-10)

- [PR#53](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/53) Use thread-safe query result for final_value ([@bbugh][])
- [PR#51](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/51) Do not cache fragments without final value ([@DmitryTsepelev][])

## 1.5.0 (2021-02-20)

- [PR#50](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/50) Add object_cache_key to CacheKeyBuilder ([@bbugh][])

## 1.4.1 (2021-01-21)

- [PR#48](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/48) Support graphql-ruby 1.12 ([@DmitryTsepelev][])

## 1.4.0 (2020-12-03)

- [PR#41](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/41) Add `keep_in_context` option ([@DmitryTsepelev][])

## 1.3.0 (2020-11-25)

- [PR#39](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/39) Implement `path_cache_key` option ([@DmitryTsepelev][])

## 1.2.0 (2020-10-26)

- [PR#37](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/37) Try to use `cache_key_with_version` or `cache_key` with Rails CacheKeyBuilder ([@bbugh][])

## 1.1.0 (2020-10-26)

- [PR#38](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/38) Support caching from other places than field or resolver  ([@DmitryTsepelev][])

## 1.0.5 (2020-10-13)

- [PR#35](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/35) Prefer using `#write_multi` on cache store when possible ([@DmitryTsepelev][])

## 1.0.4 (2020-10-12)

- [PR#34](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/34) Avoid unneded default calculation in CacheKeyBuilder ([@DmitryTsepelev][])
- [PR#31](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/31) Do not patch Connection#wrap in graphql >= 1.10.5 ([@DmitryTsepelev][])

## 1.0.3 (2020-08-31)

- [PR#29](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/29) Cache result JSON instead of connection objects ([@DmitryTsepelev][])

## 1.0.2 (2020-08-19)

- [PR#28](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/28) Support #keys method for GraphQL::FragmentCache::MemoryStore instance ([@reabiliti][])

## 1.0.1 (2020-06-17)

- [PR#25](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/25) Support fragments with aliases for CacheKeyBuilder ([@DmitryTsepelev][])

## 1.0.0 (2020-06-13)

- [PR#24](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/24) Add nil caching. **BREAKING CHANGE**: custom cache stores must also implement `#exist?(key)` method ([@DmitryTsepelev][])

## 0.1.7 (2020-06-02)

- [PR#23](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/23) Avoid extra queries after restoring connection from cache ([@DmitryTsepelev][])

## 0.1.6 (2020-05-30)

- [PR#22](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/22) Properly cache entites inside collections ([@DmitryTsepelev][])

## 0.1.5 (2020-04-28)

- [PR#19](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/19) Add connections support ([@DmitryTsepelev][])
- [PR#18](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/18) Support aliases in cache key generation ([@palkan][], [@DmitryTsepelev][])

## 0.1.4 (2020-04-25)

- Fix railtie to set up null store for tests ([@DmitryTsepelev][])

## 0.1.3 (2020-04-24)

- [PR#17](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/17) Properly build cache keys based on input arguments ([@DmitryTsepelev][])

## 0.1.2 (2020-04-24)

- [PR#16](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/16) Railtie turns off caching in test environment ([@DmitryTsepelev][])
- [PR#15](https://github.com/DmitryTsepelev/graphql-ruby-fragment_cache/pull/15) Avoid extra resolving when resolved_value is not used for building cache key ([@DmitryTsepelev][])

## 0.1.1 (2020-04-15)

- Fix using passed object as a cache key ([@palkan][])

## 0.1.0 (2020-04-14)

- Initial version ([@DmitryTsepelev][], [@palkan][], [@ssnickolay][])

[@DmitryTsepelev]: https://github.com/DmitryTsepelev
[@palkan]: https://github.com/palkan
[@ssnickolay]: https://github.com/ssnickolay
[@reabiliti]: https://github.com/reabiliti
[@bbugh]: https://github.com/bbugh
