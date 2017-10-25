import tensorflow as tf
import numpy as np
import scipy

n = 10
t = np.array(range(1, 30), np.float32) / 29
T = tf.constant(np.transpose(np.repeat([t], n, axis=0)))
j = tf.constant(np.array(range(n)), tf.float32)

def Waston():
    x = tf.placeholder(tf.float32, [n])
    f = tf.reduce_sum((j * (T ** (j - 1)) * x[0:29] - ((T ** j) * x[0:29]) ** 2 - 1) ** 2)
    f += x[0] ** 2 + (x[1] - x[0] ** 2 - 1) ** 2
    return f

if __name__ == '__main__':
    sess = tf.Session()

    x0 = tf.Variable(np.zeros(n))
    f = Waston()
    train_step = tf.train.AdamOptimizer(1e-4).minimize(f)
    sess.run(tf.globle_variables_initializer())
    sess.run(train_step, feed_dict = {x:x0})
    print f.eval(sess, feed_dict={x:x0})
