import { Kafka } from 'kafkajs'
const kafka = new Kafka({ brokers: [process.env.KAFKA_BROKER] })

const consumer = kafka.consumer({ groupId: 'pay' })
const producer = kafka.producer()
await Promise.all([consumer.connect(), producer.connect()])

await consumer.subscribe({ topic: 'orders' })
console.log('payment listening orders...')

await consumer.run({
  eachMessage: async ({ message }) => {
    const order = JSON.parse(message.value.toString())
    const paid = Math.random() > 0.1 // 90% 付款成功
    const msg = { ...order, paid }
    await producer.send({ topic: 'payments', messages: [{ value: JSON.stringify(msg) }] })
  }
})
