import express from 'express'
import { Kafka } from 'kafkajs'
import cors from 'cors'

const app = express()
app.use(express.json())

app.use(cors({
  origin: '*',                         // allow any origin
  methods: ['GET','POST','OPTIONS'],   // allow these methods
  allowedHeaders: ['Content-Type'],    // allow this header
}))
// app.options('*', cors())               // enable pre-flight for all routes

const notes = []

// 模擬幾筆通知資料之後串接完刪掉
// const notes = [
//   { id: 1, title: '付款成功', amount: 500, time: '2024-05-24 12:00' },
//   { id: 2, title: '付款失敗', amount: 200, time: '2024-05-24 13:00' },
//   { id: 3, title: '退款處理中', amount: 150, time: '2024-05-24 14:00' }
// ]

//下面是之後要拿掉註解的東西
const kafka = new Kafka({ brokers: [process.env.KAFKA_BROKER] })
const consumer = kafka.consumer({ groupId: 'note' })
await consumer.connect()
await consumer.subscribe({ topic: 'payments' })
consumer.run({
  eachMessage: async ({ message }) => notes.push(JSON.parse(message.value.toString()))
})

app.get('/notifications', (_, res) => res.json(notes))
app.listen(5000, () => console.log('note on 5000'))
