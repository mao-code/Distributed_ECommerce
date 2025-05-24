import express from 'express'
import { Kafka } from 'kafkajs'
import { v4 as uuid } from 'uuid'

const app = express()
app.use(express.json())

// === Kafka 連線（broker 位址寫在環境變數）===
const kafka = new Kafka({ brokers: [process.env.KAFKA_BROKER] })
const producer = kafka.producer()
await producer.connect()

// === 極簡假資料 ===
const products = [
  { id: 'p1', name: 'Laptop', price: 30000 },
  { id: 'p2', name: 'Headphone', price: 3000 }
]

// 讀取商品
app.get('/products', (_, res) => res.json(products))

// 下單 → 寫入 orders topic
app.post('/order', async (req, res) => {
  const { productId } = req.body
  const product = products.find(p => p.id === productId)
  if (!product) return res.status(404).send('product not found')

  const order = { orderId: uuid(), product, ts: Date.now() }
  await producer.send({ topic: 'orders', messages: [{ value: JSON.stringify(order) }] })
  res.json(order)
})

// 啟動
app.listen(3000, () => console.log('shopping on 3000'))
