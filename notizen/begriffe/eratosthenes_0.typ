#import "../../config.typ": config
#show: config

#table(columns: 10,
  "", ..range(2, 51).map(i => str(i))
)